// cart.js
document.addEventListener('DOMContentLoaded', function() {
    // Obtener los elementos del DOM
    const buttonMinus = document.getElementById('button-minus');
    const buttonPlus = document.getElementById('button-plus');
    const quantityInput = document.getElementById('productQuantity');
    const stock = parseInt(document.getElementById('stk').textContent);

    // Incrementar cantidad
    buttonPlus.addEventListener('click', () => {
        let quantity = parseInt(quantityInput.value); // Obtener el valor actual de la cantidad
        if (quantity < stock) { // Comprobar si la cantidad es menor que el stock
            quantity++; // Aumentar la cantidad
            quantityInput.value = quantity; // Actualizar el valor en el campo de entrada
        }
    });

    // Disminuir cantidad
    buttonMinus.addEventListener('click', () => {
        let quantity = parseInt(quantityInput.value); // Obtener el valor actual de la cantidad
        if (quantity > 1) { // No permitir cantidad menor a 1
            quantity--; // Disminuir la cantidad
            quantityInput.value = quantity; // Actualizar el valor en el campo de entrada
        }
    });
    
        // Opcional: No permitir ingresar un valor mayor al stock si el usuario lo cambia manualmente
    quantityInput.addEventListener('input', () => {
        let quantity = parseInt(quantityInput.value);
        if (quantity > stock) {
            quantityInput.value = stock; // Si la cantidad es mayor al stock, actualizarla al valor máximo
        }
    });
    
});


