import App from "./App";
import { render, screen, waitFor } from "@testing-library/react";
it("should show the vite logo", async () => {
  render(<App />);

  const image = screen.getByTestId("logo");

  expect(image).not.toBeNull();
});

it("should increment the count state displayed on the button when it is clicked", async () => {
  render(<App />);

  const counterButton = screen.getByTestId("counter-button");
  expect(counterButton).toHaveTextContent("count is 0");

  await waitFor(() => {
    counterButton.click();
  });

  expect(counterButton).toHaveTextContent("count is 1");
});
