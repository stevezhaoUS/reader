import { Button, ButtonGroup, List, ListItem } from '@material-ui/core';
import { WithStyles } from '@material-ui/core/styles';
import React from 'react';

export const Read: React.FC = () => {
  return (
    <List dense>
      <ListItem>
        <ButtonGroup size="small">
          <Button>Left/Right</Button>
          <Button>Up/Down</Button>
          <Button>Scroll</Button>
          <Button>Instance</Button>
        </ButtonGroup>
      </ListItem>
    </List>
  );
};
