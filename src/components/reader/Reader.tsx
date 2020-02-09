import { Container, ListItemText, ListItem } from "@material-ui/core";
import React from "react";
import { useDispatch } from "react-redux";
import { actionToggleControlPanel } from "../../actions";
import { ControlPanel } from "./ControlPanel";
import styles from "./Reader.jss";
import { FixedSizeList } from 'react-window';

const Reader: React.FC = () => {
  const dispatch = useDispatch();

  const toggleControlPanel = () => {
    dispatch(actionToggleControlPanel());
  };

  const classes = styles();

  return (
    <React.Fragment>
      <Container className={classes.root} onClick={toggleControlPanel}>

      </Container>
      <ControlPanel />
    </React.Fragment>
  );
};

export default Reader;
