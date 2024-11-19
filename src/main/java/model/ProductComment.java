package model;

import java.sql.Timestamp;

/**
 * Represents a product comment made by a user, including details such as the comment content, rating, and creation time.
 */
public class ProductComment {
    private int id;
    private int productId;
    private int userId;
    private String comment;
    private int rating;
    private Timestamp createdAt;

    /**
     * Retrieves the comment ID.
     *
     * @return The ID of the product comment.
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the comment ID.
     *
     * @param id The ID to set for the product comment.
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Retrieves the product ID associated with the comment.
     *
     * @return The product ID.
     */
    public int getProductId() {
        return productId;
    }

    /**
     * Sets the product ID associated with the comment.
     *
     * @param productId The product ID to set.
     */
    public void setProductId(int productId) {
        this.productId = productId;
    }

    /**
     * Retrieves the user ID who made the comment.
     *
     * @return The user ID.
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Sets the user ID who made the comment.
     *
     * @param userId The user ID to set.
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Retrieves the content of the comment.
     *
     * @return The comment text.
     */
    public String getComment() {
        return comment;
    }

    /**
     * Sets the content of the comment.
     *
     * @param comment The comment text to set.
     */
    public void setComment(String comment) {
        this.comment = comment;
    }

    /**
     * Retrieves the rating associated with the comment.
     *
     * @return The rating.
     */
    public int getRating() {
        return rating;
    }

    /**
     * Sets the rating associated with the comment.
     *
     * @param rating The rating to set.
     */
    public void setRating(int rating) {
        this.rating = rating;
    }

    /**
     * Retrieves the timestamp when the comment was created.
     *
     * @return The creation timestamp.
     */
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    /**
     * Sets the timestamp when the comment was created.
     *
     * @param createdAt The timestamp to set.
     */
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
