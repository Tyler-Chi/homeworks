
//reducer is a function that takes in the current state
//and an action, and returns an updated state based
//on the action type.

const initialState = {
  baseCurrency: "Please select",
  rates: {}
};

// return state; // remove this and fill out the body of the reducer function

//remember, the reducer is the function that returns the apps current state and incoming actions, determines how to update the store's state, and returns the next state.


//remember an action is an object with a type, and is  basically a hash of information.

const reducer = (state = initialState, action) => {
  switch(action.type) {
    case "SWITCH_CURRENCY":
      return {
        baseCurrency: action.baseCurrency,
        rates: action.rates
      };
    default:
      return state;
  }
};

export default reducer;


//. Add a case statement to check for this action type. It should return a new object with the correct properties. We can grab those off the action (i.e. action.rates and action.baseCurrency).
