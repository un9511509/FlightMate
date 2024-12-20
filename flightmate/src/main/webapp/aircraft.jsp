<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="./components/head.jsp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
	<title>FlightMate | Aircrafts</title>
</head>

<body class="background">
    <jsp:include page='./components/header.jsp' />

   <main>
        <div class="container mx-auto mt-8 w-72 rounded border-1 bg-white">
            <h1 class="center">Add New Aircraft</h1>
            
            <c:if test="${not empty success}">
                <div class="alert success center">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert error center">${error}</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/aircraft" method="post" class="my-2">
                <div class="form-group space-evenly">
                    <label for="aircraftModel" class="form-label">Aircraft Model:</label>
                    <input type="text" id="aircraftModel" name="aircraftModel" class="form-input flex-2 border-2 rounded" required>
                </div>

                <div class="form-group space-evenly">
                    <label for="manufactureDate" class="form-label">Manufacture Date:</label>
                    <input type="date" id="manufactureDate" name="manufactureDate" class="form-input flex-2 border-2 rounded" required>
                </div>

                <div class="form-group space-evenly">
                    <label for="lastMaintenanceDate" class="form-label">Last Maintenance Date:</label>
                    <input type="date" id="lastMaintenanceDate" name="lastMaintenanceDate" class="form-input flex-2 border-2 rounded" required>
                </div>

                <div class="form-group space-evenly">
                    <label for="nextMaintenanceDate" class="form-label">Next Maintenance Date:</label>
                    <input type="date" id="nextMaintenanceDate" name="nextMaintenanceDate" class="form-input flex-2 border-2 rounded" required>
                </div>

                <div class="form-group space-evenly">
                    <label for="aircraftNotes" class="form-label">Aircraft Notes:</label>
                    <textarea id="aircraftNotes" name="aircraftNotes" class="form-input flex-2 border-2 rounded"></textarea>
                </div>

                <div class="form-group space-evenly">
                    <label for="administratorId" class="form-label">Administrator:</label>
                    <select id="administratorId" name="administratorId" class="form-input border-2 rounded" required>
                        <c:forEach var="admin" items="${administrators}">
                            <option value="${admin.getUserId()}">${admin.getFirstName()} ${admin.getLastName()}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group space-evenly">
                    <label for="airportId" class="form-label">Airport:</label>
                    <select id="airportId" name="airportId" class="form-input border-2 rounded" required>
                        <c:forEach var="airport" items="${airports}">                            
                        <option value="${airport.getAirportId()}">${airport.getAirportName()}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="center my-2">
                    <button type="submit" class="btn success">Submit</button>
                </div>
            </form>
        </div>
    </main>
</body>
</html>
