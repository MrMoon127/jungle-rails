describe('product details page', () => {
  
  it('can visit the home page', () => {
    cy.visit('/');
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("lets you click on a product to see more details", () => {
    cy.visit('/')
    cy.get('.products article').first().click()
    cy.url().should('include', '/products/2')
  })

})