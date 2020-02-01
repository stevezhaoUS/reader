import { createStyles } from '@material-ui/core';
import { makeStyles, Theme } from '@material-ui/core/styles';

export default makeStyles((theme: Theme) =>
  createStyles({
    root: {
      display: 'flex',
      flexWrap: 'wrap',
      justifyContent: 'space-around',
      overflow: 'hidden',
      backgroundColor: theme.palette.background.paper
    },
    gridList: {
      width: '100%',
      padding: theme.spacing(2),
      height: 450
    },
    icon: {
      color: 'rgba(255, 255, 255, 0.54)'
    }
  })
);
