import {
  Button,
  ButtonGroup,
  Divider,
  List,
  ListItem,
  ListItemText
} from '@material-ui/core';
import React from 'react';
export const Font: React.FC = () => (
  <List disablePadding>
    <ListItem>
      <ListItemText primary="Font Size" />
      <ButtonGroup>
        <Button>A-</Button>
        <Button>A</Button>
        <Button>A+</Button>
      </ButtonGroup>
    </ListItem>
    <Divider />
    <ListItem>
      <ListItemText primary="row spacing" />
      <ButtonGroup>
        <Button>Narrow</Button>
        <Button>Default</Button>
        <Button>Loose</Button>
      </ButtonGroup>
    </ListItem>
  </List>
);
