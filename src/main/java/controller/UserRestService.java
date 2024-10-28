package controller;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import model.User;
import model.UserDAO;

import java.util.List;

@Path("/users")
public class UserRestService {

    // 用户注册 REST API
    @POST
    @Path("/register")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response registerUser(User user) {
        try {
            UserDAO userDAO = new UserDAO();
            userDAO.registerUser(user);
            return Response.status(Response.Status.CREATED).entity("User registered successfully").build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Registration failed").build();
        }
    }

    // 获取特定用户名的用户信息
    @GET
    @Path("/{username}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getUserByUsername(@PathParam("username") String username) {
        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByUsername(username);
            if (user != null) {
                return Response.ok(user).build();
            } else {
                return Response.status(Response.Status.NOT_FOUND).entity("User not found").build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error occurred while fetching user").build();
        }
    }

    // 获取所有用户信息（管理员功能）
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllUsers() {
        try {
            UserDAO userDAO = new UserDAO();
            List<User> users = userDAO.getAllUsers();
            return Response.ok(users).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error occurred while fetching users").build();
        }
    }
}