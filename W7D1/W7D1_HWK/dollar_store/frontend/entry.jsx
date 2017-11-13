import React from 'react';
import ReactDOM from 'react-dom';
import Widget from './components/widget';
import store from './store';

//rendering the widget class, passing it the prop of store. 

document.addEventListener("DOMContentLoaded", function(){
  ReactDOM.render(<Widget store={store} />, document.getElementById('root'));
});
