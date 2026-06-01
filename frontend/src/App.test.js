import { render, screen } from '@testing-library/react';
import App from './App';

test('renders Intelligent DevOps Platform', () => {
  render(<App />);
  expect(screen.getByText(/Intelligent DevOps Platform/i)).toBeInTheDocument();
});

