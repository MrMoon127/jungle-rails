describe('home page', () => {
  
  it('can visit the home page', () => {
    cy.visit('/');
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("adds a product to the cart and checks that the cart count increases by 1", () => {
    cy.contains('My Cart (0)')

    cy.contains('Add').first().click({force: true})

    cy.contains('My Cart (1)')
  })

})