{
  # makes binaries (specically uv) install in ~/.local/bin
  environment.localBinInPath = true;

  environment.variables = {
    # Stops uv from downloading python binaries automatically if needed
    "UV_PYTHON_DOWNLOADS" = "never";
  };
}
