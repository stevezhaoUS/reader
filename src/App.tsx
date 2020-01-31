import { Container } from '@material-ui/core';
import React from 'react';
import { connect } from 'react-redux';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import './App.jss';
import Shelf from './components/shelf/Shelf';
import Reader from './components/reader/Reader';

const routes = [
  {
    path: '/shelf',
    component: Shelf
  },
  {
    path: '/read',
    component: Reader
  }
];

const App: React.FC = () => {
  return (
    <Router>
      <Container fixed disableGutters>
        <div className="grow">
          <Switch>
            {routes.map((route, i) => (
              <RouteWithSubRoutes key={i} {...route} />
            ))}
          </Switch>
          <footer />
        </div>
      </Container>
    </Router>
  );
};

function RouteWithSubRoutes(route: any) {
  return (
    <Route
      path={route.path}
      render={props => <route.component {...props} routes={route.routes} />}
    />
  );
}

const mapStateToProps = (state: any) => ({
  sideMenu: state.sideMenu
});

export default connect(mapStateToProps)(App);
