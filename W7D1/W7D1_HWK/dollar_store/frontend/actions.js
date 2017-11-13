
const selectCurrency = (baseCurrency,rates) => {


    //this return value is an ACTION!
    return {
      type: "SWITCH_CURRENCY",

      //this values were pulled from the function arguments.
      baseCurrency: baseCurrency;
      rates: rates
    }
}

export default selectCurrency;
