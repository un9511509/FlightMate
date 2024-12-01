<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="./components/head.jsp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
	<title>FlightMate | Dashboard</title>
</head>
<body class="background">
	<jsp:include page='./components/header.jsp' />
	<main>
		<header class="mb-2">
			<ul class="main-header">
		        <li><a href="upload" class="btn">Upload Documents</a></li>
		        <li><a href="feedback" class="btn">Submit Feedback</a></li>
		        <li><a href="airport" class="btn">See Airports</a></li>
		        <c:if test="${user.getRole().equals(roles['ADMINISTRATOR'])}">
			        <li><a href="aircraft" class="btn">Add New Aircraft</a></li>
			        <li><a href="flight" class="btn">Manage Flights</a></li>
		        </c:if>
	   		</ul>
		</header>
		<section class="container mt-2">		
			<h1 class="subtitle">Dashboard</h1>
			<p>Hello ${user.getFirstName()}</p>
			<p>Your role: ${user.getRole()}</p>
		</section>

        <%-- Only display the form for pilots --%>
        <c:if test="${sessionScope.user.role == 'PILOT'}">
            <h2>Log Flight Hours</h2>
            <form action="logFlightHours" method="post">
                <label for="flight_date">Flight Date:</label>
                <input type="date" id="flight_date" name="flight_date" required>
                <label for="hours_flighted">Hours Flown:</label>
                <input type="number" id="hours_flighted" name="hours_flighted" step="0.01" required>
                <label for="notes">Notes (optional):</label>
                <textarea id="notes" name="notes"></textarea>
                <button type="submit">Log Flight Hours</button>
            </form>
        </c:if>

        <%-- Pending Flight Hours for Admins --%>
        <c:if test="${sessionScope.user.role == 'ADMINISTRATOR'}">
            <h2>Pending Flight Hour Approvals</h2>
            <table>
                <thead>
                    <tr>
                        <th>Pilot Name</th>
                        <th>Flight Date</th>
                        <th>Hours</th>
                        <th>Notes</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="hour" items="${pendingFlightHours}">
                        <tr>
                            <td>${hour.pilotName}</td>
                            <td>${hour.flightDate}</td>
                            <td>${hour.hoursFlighted}</td>
                            <td>${hour.notes}</td>
                            <td>
                                <form action="approveFlightHours" method="post">
                                    <input type="hidden" name="id" value="${hour.id}" />
                                    <button type="submit" name="action" value="approve">Approve</button>
                                    <button type="submit" name="action" value="reject">Reject</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

		<c:if test="${user.getRole().equals(roles['ADMINISTRATOR'])}">
			<h2>User Management</h2>
            <table class="dashboard-table w-full border-2 rounded">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.firstName} ${user.lastName}</td>
                            <td>${user.email}</td>
                            <td>${user.role}</td>
                            <td>
                                <div class=" flex">
                                    <a href="dashboard?action=edit&id=${user.userId}" class="btn">Edit</a>
                                    <a href="dashboard?action=delete&id=${user.userId}" class="btn error"
                                        onclick="return confirm('Are you sure you want to delete this user?');">
                                        Delete
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
	</main>
</body>
</html>
