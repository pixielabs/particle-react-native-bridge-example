import React, { Component } from 'react';
import {
  NativeModules,
  NativeEventEmitter,
  StyleSheet,
  View,
  Text,
  Button } from 'react-native';

const ParticleSetup = NativeModules.ParticleSetup;
const particleSetupEmitter = new NativeEventEmitter(ParticleSetup);

type Props = {};
export default class App extends Component<Props> {

  constructor(props) {
    super();
    this.state = {
      buttonName: '',
      buttonId: ''
    }
  }

  componentDidMount() {
    this.subscription = particleSetupEmitter.addListener(
      'DeviceSetup',
      ({id, name}) => { this.setState({ buttonName: name, buttonId: id }); }
    );
  }

  componentWillUnmount() {
    this.subscription.remove();
  }

  renderButton() {
    return <Button title='Add your button' onPress={() => { ParticleSetup.setup() }} />
  }

  renderSuccessMessage() {
    let message = `Added button '${this.state.buttonName}' with id ${this.state.buttonId}`
    return <Text>{message}</Text>
  }

  render() {
    return (
      <View style={styles.container}>
        {(this.state.buttonName && this.state.buttonId) ? this.renderSuccessMessage() : this.renderButton()}
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  }
});
