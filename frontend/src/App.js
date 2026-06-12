import React, { useEffect, useMemo, useState } from 'react';
import './styles.css';

const API_BASE_URL = process.env.REACT_APP_API_BASE_URL;

function useInterval(callback, delay) {
  const savedCallback = React.useRef(callback);
  useEffect(() => {
    savedCallback.current = callback;
  }, [callback]);

  useEffect(() => {
    if (delay === null) return;
    const id = setInterval(() => savedCallback.current(), delay);
    return () => clearInterval(id);
  }, [delay]);
}

function Card({ title, children }) {
  return (
    <div className="card">
      <div className="cardTitle">{title}</div>
      <div className="cardBody">{children}</div>
    </div>
  );
}

async function fetchJson(url) {
  const res = await fetch(url, { headers: { Accept: 'application/json' } });
  const text = await res.text();
  if (!res.ok) {
    throw new Error(`Request failed (${res.status}): ${text}`);
  }
  return text ? JSON.parse(text) : {};
}

export default function App() {
  const [health, setHealth] = useState(null);
  const [buildInfo, setBuildInfo] = useState(null);
  const [info, setInfo] = useState(null);
  const [error, setError] = useState(null);

  const endpoints = useMemo(() => {

    return {
      health: `${API_BASE_URL}/health`,
      build: `${API_BASE_URL}/build`,
      info: `${API_BASE_URL}/info`,

    };
  }, []);


  async function refresh() {
    try {
      setError(null);
      const [h, b, i] = await Promise.all([
        fetchJson(endpoints.health),
        fetchJson(endpoints.build),
        fetchJson(endpoints.info),
      ]);
      setHealth(h);
      setBuildInfo(b);
      setInfo(i);
    } catch (e) {

      setError(e.message || String(e));
    }
  }

  useEffect(() => {
    refresh();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  useInterval(() => {
    refresh();
  }, 10000);

  return (
    <div className="page">
      <header className="header">
        <div>
          <div className="title">Intelligent DevOps Platform</div>
          <div className="subtitle">Production-grade platform demo</div>
        </div>
        <div className="status">
          <span className={`pill ${health?.status === 'UP' ? 'up' : 'down'}`}>
            {health?.status || 'UNKNOWN'}
          </span>
        </div>
      </header>

      {error && (
        <div className="errorBox">
          <div className="errorTitle">Error</div>
          <div className="errorText">{error}</div>
        </div>
      )}

      <div className="grid">
        <Card title="Health Status">
          {health ? (
            <div className="kv">
              <div className="kvRow">
                <span>Status</span>
                <span className="mono">{health.status}</span>
              </div>
              <div className="kvRow">
                <span>Correlation ID</span>
                <span className="mono">{health.correlationId}</span>
              </div>
              <div className="kvRow">
                <span>Service</span>
                <span className="mono">{health.service}</span>
              </div>
            </div>
          ) : (
            <div className="muted">Loading...</div>
          )}
        </Card>

        <Card title="Build Information">
          {buildInfo ? (
            <div className="kv">
              <div className="kvRow">
                <span>Version</span>
                <span className="mono">{buildInfo.version}</span>
              </div>
              <div className="kvRow">
                <span>Commit</span>
                <span className="mono">{buildInfo.commit}</span>
              </div>
              <div className="kvRow">
                <span>Branch</span>
                <span className="mono">{buildInfo.branch}</span>
              </div>
              <div className="kvRow">
                <span>Timestamp</span>
                <span className="mono">{buildInfo.timestamp}</span>
              </div>
              <div className="kvRow">
                <span>Server Time</span>
                <span className="mono">{buildInfo.serverTime}</span>
              </div>
              <div className="kvRow">
                <span>Correlation ID</span>
                <span className="mono">{buildInfo.correlationId}</span>
              </div>
            </div>
          ) : (
            <div className="muted">Loading...</div>
          )}
        </Card>

        <Card title="Deployment & Monitoring">
          <div className="muted">
            <div>Use backend actuator and Prometheus metrics for monitoring.</div>
            <div className="links">

              <a href="/actuator/health" target="_blank" rel="noreferrer">
                Actuator Health
              </a>
              <a href="/actuator/prometheus" target="_blank" rel="noreferrer">
                Prometheus Metrics
              </a>
              <a href={info?.grafanaUrl || 'about:blank'} target="_blank" rel="noreferrer">
                Grafana (configured in cluster)
              </a>
              <a
                href={info?.lokiUrl ? String(info.lokiUrl).replace(/\/+$/, '') : 'about:blank'}
                target="_blank"
                rel="noreferrer"
              >
                Loki (Health)
              </a>


            </div>

          </div>
        </Card>
      </div>

      <footer className="footer">
        <div className="muted">
          API base: <span className="mono">{API_BASE_URL}</span>
        </div>
      </footer>
    </div>
  );
}

