<%@page import="com.journaldev.hibernate.model.Pizza"%>
<%@page import="com.journaldev.hibernate.model.Ingredient"%>
<%@page import="com.journaldev.hibernate.model.Dough"%>
<%@page import="java.util.List"%>
<%@page import="com.journaldev.hibernate.model.User"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Pizza</title>
<style type="text/css">
	table, tr, td{
		font-size: .9em;
		border: 3px groove;
		padding: 5px;
		background-color: #dddddd;
	}

</style>
</head>
<body>

<form action="http://localhost:8080/PIZZERIA/UpdateAndDeletePizzaServletController" method="post">
<!-- Tabella per selezionare l'impasto -->
		<p>Check the dough you want!</p>
		<table>
			<% 
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("persistencePizzeria");
			EntityManager entityManager = emf.createEntityManager();
			entityManager.getTransaction().begin();
			
			Pizza pizza = entityManager.find(Pizza.class, request.getAttribute("pizzaId"));
			
			List<Dough> doughs = entityManager.createNamedQuery("selectAllDough").getResultList();
			
			List<Ingredient> ingredients = entityManager.createNamedQuery("selectAllIngredient").getResultList();
			
			entityManager.getTransaction().commit();
			
			for(Dough dough : doughs){
				
			%>
				<tr>
					<input type="radio" name="doughId" value="<%= dough.getId() %>"
						<% if(pizza.getDough().getId() == dough.getId()){ %>
						checked="checked"
						<% } %>
					>
	� 				<label for="html"><%= dough.getName() %></label><br>
				</tr>
			<% } %>
		</table>
			
		<input type="text" name="pizzaId" value="<%= pizza.getId() %>" style="display: none;">
		<input type="text" name="userId" value="<%= pizza.getUser().getId() %>" style="display: none;">
		
		<!-- Tabella per selezionare gli ingredienti -->
		<p>Check the ingredients you want!</p>
		<table>
			<% 
		
			for(Ingredient ingredient : ingredients){
			%>
			<tr>
				<input type="checkbox" name="ingredientsId" value="<%= ingredient.getId() %>" 
					<% if(pizza.getIngredients().contains(entityManager.find(Ingredient.class, ingredient.getId()))){ %>
						checked="checked"
					<% } %>
				>
� 				<label for="html"><%= ingredient.getName() %></label><br>
			</tr>
			<% } %>
		</table>
		
		<table>
			<tr>
				<td>Insert pizza name!</td>
				<td> <input type="text" name="pizzaName" placeholder="Insert pizza name" value="<%=pizza.getName()%>"> </td>
			</tr>
		
			<tr>
				<td colspan="2">
					<input type="submit" value="Submit">
				</td>
			</tr>
		</table>
</form>

</body>
</html>