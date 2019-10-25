import React from "react";
import { Router } from "@reach/router";
import phoneCodeList from "./phoneCodeList";

function App() {
  return (
    <Router>
      <phoneCodeList path="/" />
    </Router>
  );
}

export default App;
