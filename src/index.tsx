import CssBaseline from '@material-ui/core/CssBaseline';
import { createMuiTheme, ThemeProvider } from '@material-ui/core/styles';
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import * as serviceWorker from './serviceWorker';
import { store } from './store';
import { Provider } from 'react-redux';

const theme = createMuiTheme({
  palette: {
    primary: {
      main: '#556cd6'
    }
  }
});

function render() {
  ReactDOM.render(
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Provider store={store}>
        <App />
      </Provider>
    </ThemeProvider>,
    document.getElementById('root')
  );
}
// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA

render();
serviceWorker.unregister();
