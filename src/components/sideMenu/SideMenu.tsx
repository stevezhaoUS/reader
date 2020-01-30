import { Drawer, DrawerProps, List, ListItem, ListItemText, ListItemIcon } from '@material-ui/core';
import React from 'react';
import { Inbox as InboxIcon, Mail as MailIcon} from '@material-ui/icons';

export const SideMenu: React.FC<DrawerProps> = (props: DrawerProps) => (
    <Drawer anchor="left" open={props.open} onClose={props.onClose}>
        <List>
            {['Library', 'Shelf', 'BookMark'].map((text, index) => (
                <ListItem button key={text}>
                    <ListItemIcon>
                        {index % 2 === 0 ? <InboxIcon/> : <MailIcon />}
                    </ListItemIcon>
                    <ListItemText primary={text} />
                </ListItem>
            ))}
        </List>
    </Drawer>
)
