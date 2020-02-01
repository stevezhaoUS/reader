import React from 'react';
import { makeStyles } from '@material-ui/core';

const useStyles = makeStyles({
  root: {
    height: 'calc(100vh - 58px)'
  }
});

export const BookMark: React.FC = props => {
  const classes = useStyles();
  return <div className={classes.root}>sample</div>;
};
