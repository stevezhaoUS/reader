import { Container } from "@material-ui/core";
import React from "react";
import { useDispatch } from "react-redux";
import { actionToggleControlPanel } from "../../actions";
import { ControlPanel } from "./ControlPanel";
import styles from "./Reader.jss";

const Reader: React.FC = () => {
  const dispatch = useDispatch();

  const toggleControlPanel = () => {
    dispatch(actionToggleControlPanel());
  };

  const classes = styles();

  return (
    <React.Fragment>
      <Container className={classes.root} onClick={toggleControlPanel}>
        <h1>READING...</h1>
      </Container>
      <ControlPanel />
    </React.Fragment>
  );
};

export default Reader;
