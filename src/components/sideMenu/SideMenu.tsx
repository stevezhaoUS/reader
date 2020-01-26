import { Drawer, List, ListItem, ListItemIcon, ListItemText } from '@material-ui/core';
import { Inbox as InboxIcon, Mail as MailIcon } from '@material-ui/icons';
import React from 'react';
import { connect } from 'react-redux';
import { actionToggleSideMenu } from '../../actions/Menus';


function mapStateToProps(state: any) {
    return {
        show: state.SideMenu.open
    }
}

const SideMenu: React.FC<any> = (props) => {
    const { dispatch } = props;
    const toggleSideMenu = () => {
       dispatch(actionToggleSideMenu()) 
    }

    return (
        <Drawer anchor="left" open={props.show} onClose={toggleSideMenu}>
            <List>
                {['Library', 'Shelf', 'BookMark'].map((text, index) => (
                    <ListItem button key={text}>
                        <ListItemIcon>
                            {index % 2 === 0 ? <InboxIcon /> : <MailIcon />}
                        </ListItemIcon>
                        <ListItemText primary={text}/>
                    </ListItem>
                ))}
            </List>
        </Drawer>
    )
}

export default connect(mapStateToProps)(SideMenu);