import ReactDOM from 'react-dom'
import React from 'react'
import App from "./components/App";

import { AuthClient } from "@dfinity/auth-client";
// "@dfinity/auth-client": "^0.10.3",
//     "@dfinity/authentication": "^0.10.3",

const init = async () => { 


  const authClient = await AuthClient.create(); 

  if (await authClient.isAuthenticated()){ 
    console.log("Logged In"); 
  }

  // Using Dinfinity's internet identity to ensure the entity is who they say they are. 
  await authClient.login({ 
    identityProvider: "https://identity.ic0.app/#authorize", 
    onSuccess: () => { 
      handleAuthenticated(authClient);  
    }

  }); 
}

async function handleAuthenticated(authClient){ 
  ReactDOM.render(<App />, document.getElementById("root")); 
}

init();


