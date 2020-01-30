
import { Button, ButtonGroup, List, ListItem } from '@material-ui/core';
import React from 'react';
import { makeStyles, createStyles, Theme } from '@material-ui/core/styles'

export const Read = () => {
    return (
        <List dense >
            <ListItem>
                <ButtonGroup size="small">
                    <Button>Left/Right</Button>
                    <Button>Up/Down</Button>
                    <Button>Scroll</Button>
                    <Button>Instance</Button>
                </ButtonGroup>
            </ListItem>
        </List>
    )
}
