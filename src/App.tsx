import { Container } from "@material-ui/core";
import React from "react";
import { connect, DispatchProp } from "react-redux";
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Redirect
} from "react-router-dom";
import "./App.jss";
import Shelf from "./components/shelf/Shelf";
import Reader from "./components/reader/Reader";
import * as actions from "./actions/shelfAction";
import { IAction } from "./types/actions";

const App: React.FC<DispatchProp<IAction>> = props => {
  const { dispatch } = props;
  return (
    <Router>
      <Container fixed disableGutters>
        <div className="grow">
          <Switch>
            <Route
              path="/shelf"
              render={() => {
                dispatch(actions.fetchShelf());
                return <Shelf />;
              }}
            />
            <Route path="/read" component={Reader} />
            <Route path="/" render={() => <Redirect to="shelf" />} />
          </Switch>
          <footer />
        </div>
      </Container>
    </Router>
  );
};

const mapStateToProps = (state: any) => ({
  sideMenu: state.sideMenu
});

export default connect(mapStateToProps)(App);
