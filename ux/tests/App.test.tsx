import React from 'react';
import { render, screen } from '@testing-library/react';
import App from '../src/App';

test('renders title', () => {
  render(<App />);
  const linkElement = screen.getByText(/Game of Bros/i);
  expect(linkElement).toBeInTheDocument();
});
