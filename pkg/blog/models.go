package blog

import "time"

type User struct {
	UserID      int       `db:"user_id"`
	Username    string    `db:"username"`
	Email       string    `db:"email"`
	Password    string    `db:"password"`
	DisplayName string    `db:"displayname"`
	Bio         string    `db:"bio"`
	CreatedAt   time.Time `db:"created_at"`
	UpdatedAt   time.Time `db:"updated_at"`
}

type Category struct {
	CategoryID  int    `db:"category_id"`
	Name        string `db:"name"`
	Description string `db:"description"`
}

type Tag struct {
	TagID int    `db:"tag_id"`
	Name  string `db:"name"`
}

type Post struct {
	PostID      int        `db:"post_id"`
	UserID      int        `db:"user_id"`
	Title       string     `db:"title"`
	Summary     string     `db:"summary"`
	Body        string     `db:"body"`
	Status      string     `db:"status"`
	PublishedAt *time.Time `db:"published_at"`
	CreatedAt   time.Time  `db:"created_at"`
	UpdatedAt   time.Time  `db:"updated_at"`
}

type PostCategory struct {
	PostID     int `db:"post_id"`
	CategoryID int `db:"category_id"`
}

type PostTag struct {
	PostID int `db:"post_id"`
	TagID  int `db:"tag_id"`
}

type Comment struct {
	CommentID int       `db:"comment_id"`
	PostID    int       `db:"post_id"`
	UserID    int       `db:"user_id"`
	ParentID  *int      `db:"parent_id"`
	Body      string    `db:"body"`
	CreatedAt time.Time `db:"created_at"`
	UpdatedAt time.Time `db:"updated_at"`
}

type PostLike struct {
	UserID    int       `db:"user_id"`
	PostID    int       `db:"post_id"`
	CreatedAt time.Time `db:"created_at"`
}

type CommentLike struct {
	UserID    int       `db:"user_id"`
	CommentID int       `db:"comment_id"`
	CreatedAt time.Time `db:"created_at"`
}

type Media struct {
	MediaID    int       `db:"media_id"`
	UploaderID int       `db:"uploader_id"`
	PostID     int        `db:"post_id"`
	FileURL    string    `db:"file_url"`
	FileType   string    `db:"file_type"`
	AltText    string    `db:"alltext"`
	UploadedAt time.Time `db:"uploaded_at"`
}