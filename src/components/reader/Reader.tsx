import { connect, useDispatch } from 'react-redux';
import { ControlPanel } from './ControlPanel';
import React from 'react';
import { actionToggleControlPanel } from '../../actions/Menus';
import styles from './Reader.jss';
import { Container } from '@material-ui/core';

const Reader: React.FC = () => {
    const dispatch = useDispatch();

    const toggleControlPanel = () => {
        dispatch(actionToggleControlPanel())
    }

    const classes = styles()

    return (
        <React.Fragment>
            <Container className={classes.root}
                onClick={toggleControlPanel}>
                <h1>READING...</h1>
            </Container>
            <ControlPanel />
        </React.Fragment>
    )
}

export default Reader