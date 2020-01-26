import React, { Component } from 'react'
import { connect } from 'react-redux'
import styles from './Reader.jss'

class Reader extends Component {
    render() {
        return (
            <div> <h1>READING...</h1> </div>
        )
    }
}

export default connect()(Reader)