package controller;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import model.User;
import DAO.UserDAO;
import util.AsymmetricEncryptionUtil;
import util.SymmetricEncryptionUtil;

import javax.crypto.SecretKey;
import java.util.List;

/**
 * RESTful web service for managing user-related operations.
 * Provides APIs for public key retrieval, user registration, fetching user details, and listing all users.
 */
@Path("/users")
public class UserRestService {

    /**
     * Retrieves the server's public key for encryption.
     *
     * @return the public key as a plain text string, or an error message in case of failure.
     */
    @GET
    @Path("/publicKey")
    @Produces(MediaType.TEXT_PLAIN)
    public String getPublicKey() {
        try {
            return AsymmetricEncryptionUtil.getPublicKey();
        } catch (Exception e) {
            e.printStackTrace();
            return "Error retrieving public key";
        }
    }

    /**
     * Registers a new user with the provided information.
     *
     * @param user the {@link User} object containing user details in JSON format.
     * @return a response indicating the success or failure of the registration.
     */
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

    /**
     * Fetches user details by username.
     * Encrypts the user's email using symmetric encryption before returning the data.
     *
     * @param username the username of the user to fetch.
     * @return a response containing the user details if found, or an appropriate error message.
     */
    @GET
    @Path("/{username}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getUserByUsername(@PathParam("username") String username) {
        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByUsername(username);
            if (user != null) {
                SecretKey secretKey = SymmetricEncryptionUtil.generateKey();
                String encryptedEmail = SymmetricEncryptionUtil.encrypt(user.getEmail(), secretKey);
                user.setEmail(encryptedEmail);
                return Response.ok(user).build();
            } else {
                return Response.status(Response.Status.NOT_FOUND).entity("User not found").build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Error occurred while fetching user").build();
        }
    }

    /**
     * Retrieves a list of all registered users.
     * This endpoint is intended for administrative purposes.
     *
     * @return a response containing the list of all users, or an error message in case of failure.
     */
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
