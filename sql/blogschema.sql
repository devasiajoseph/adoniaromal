CREATE TABLE users (
    user_id     SERIAL          PRIMARY KEY,
    username    VARCHAR(50)     NOT NULL UNIQUE,
    email       VARCHAR(255)    NOT NULL UNIQUE,
    pwd  VARCHAR(255)  NOT NULL,
    displayname VARCHAR(100),
    bio         TEXT,
    created_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE categories (
    category_id   SERIAL        PRIMARY KEY,
    name          VARCHAR(100)  NOT NULL UNIQUE,
    description   TEXT
);
CREATE TABLE tags (
    tag_id  SERIAL        PRIMARY KEY,
    name    VARCHAR(50)   NOT NULL UNIQUE
);
CREATE TABLE posts (
    post_id      SERIAL          PRIMARY KEY,
    user_id    INT             NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    title        VARCHAR(255)    NOT NULL,
    summary      TEXT,
    body         TEXT            NOT NULL,
    status       VARCHAR(20)     NOT NULL DEFAULT 'draft'
                                 CHECK (status IN ('draft', 'published', 'archived')),
    published_at TIMESTAMP,
    created_at   TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP
);
 
CREATE TABLE post_categories (
    post_id      INT  NOT NULL REFERENCES posts(post_id)       ON DELETE CASCADE,
    category_id  INT  NOT NULL REFERENCES categories(category_id) ON DELETE CASCADE,
    PRIMARY KEY (post_id, category_id)
);
 
CREATE TABLE post_tags (
    post_id  INT  NOT NULL REFERENCES posts(post_id)  ON DELETE CASCADE,
    tag_id   INT  NOT NULL REFERENCES tags(tag_id)    ON DELETE CASCADE,
    PRIMARY KEY (post_id, tag_id)
);
CREATE TABLE comments (
    comment_id  SERIAL    PRIMARY KEY,
    post_id     INT       NOT NULL REFERENCES posts(post_id)    ON DELETE CASCADE,
    user_id     INT       NOT NULL REFERENCES users(user_id)    ON DELETE CASCADE,
    parent_id   INT       REFERENCES comments(comment_id)       ON DELETE CASCADE,  
    body        TEXT      NOT NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE likes (
    like_id     SERIAL      PRIMARY KEY,
    user_id     INT         NOT NULL REFERENCES users(user_id)  ON DELETE CASCADE,
    post_id     INT         REFERENCES posts(post_id)           ON DELETE CASCADE,
    comment_id  INT         REFERENCES comments(comment_id)     ON DELETE CASCADE,
    created_at  TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (
        (post_id IS NOT NULL AND comment_id IS NULL) OR
        (post_id IS NULL AND comment_id IS NOT NULL)
    ),
    UNIQUE (user_id, post_id),
    UNIQUE (user_id, comment_id)
);
CREATE TABLE media (
    media_id    SERIAL          PRIMARY KEY,
    uploader_id INT             NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    post_id     INT             REFERENCES posts(post_id)          ON DELETE CASCADE,
    file_url    VARCHAR(500)    NOT NULL,
    file_type   VARCHAR(50),    
    alltext    VARCHAR(255),
    uploaded_at TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP
);