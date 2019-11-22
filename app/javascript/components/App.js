import React from "react";
import { Router } from "@reach/router";
import PhoneCodeList from "./PhoneCodeList";

function App() {
  return (
    <Router>
      <PhoneCodeList path="/" />
    </Router>
  );
}

export default App;
