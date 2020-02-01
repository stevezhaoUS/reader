import React from 'react';
import {
  List,
  ListItem,
  Divider,
  Slider,
  ListItemText,
  Switch,
  IconButton
} from '@material-ui/core';
import Brightness1RoundedIcon from '@material-ui/icons/Brightness1Rounded';
import Brightness3RoundedIcon from '@material-ui/icons/Brightness3Rounded';

export const Brightness: React.FC = () => (
  <List disablePadding dense>
    <ListItem>
      <IconButton>
        <Brightness3RoundedIcon fontSize="small" />
      </IconButton>
      <Slider defaultValue={30} />
      <IconButton>
        <Brightness1RoundedIcon />
      </IconButton>
    </ListItem>
    <Divider />
    <ListItem>
      <ListItemText primary="Dark Mode" />
      <Switch disableRipple />
    </ListItem>
  </List>
);
