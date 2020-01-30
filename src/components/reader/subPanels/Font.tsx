import React from 'react';
import { List, ListItem, ListSubheader, ButtonGroup, Button, ListItemIcon, ListItemText, Typography, Divider } from '@material-ui/core';
export const Font = () => (
    <List disablePadding>
        <ListItem>
            <ListItemText primary="Font Size">
            </ListItemText>
             <ButtonGroup >
                 <Button>A-</Button>
                 <Button>A</Button>
                 <Button>A+</Button>
             </ButtonGroup>
        </ListItem>
        <Divider />
        <ListItem>
            <ListItemText primary="row spacing" />
                <ButtonGroup >
                 <Button>Narrow</Button>
                 <Button>Default</Button>
                 <Button>Loose</Button>
             </ButtonGroup>
        </ListItem>
    </List>
)