window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
      addTaxDom.innerHTML = (Math.floor(inputValue * 0.1))
    const addProfitDom = document.getElementById("profit");
      const value_result = Math.floor(inputValue * 0.1)
      addProfitDom.innerHTML = (inputValue - value_result)
  })
});