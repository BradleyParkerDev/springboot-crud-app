-- Enable pgcrypto for UUID generation
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    user_id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name   TEXT        NOT NULL,
    last_name    TEXT        NOT NULL,
    email_address TEXT       NOT NULL UNIQUE,
    user_name    TEXT        NOT NULL UNIQUE,
    password     TEXT        NOT NULL,
    last_updated TIMESTAMP   NOT NULL DEFAULT now(),
    created_at   TIMESTAMP   NOT NULL DEFAULT now()
);

-- Auto-update last_updated on UPDATE
CREATE OR REPLACE FUNCTION set_last_updated() RETURNS trigger AS $$
BEGIN
    NEW.last_updated := now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS users_set_last_updated ON users;
CREATE TRIGGER users_set_last_updated
BEFORE UPDATE ON users
FOR EACH ROW EXECUTE FUNCTION set_last_updated();

-- User sessions table
CREATE TABLE IF NOT EXISTS user_sessions (
    session_id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID REFERENCES users(user_id),
    start_time      TIMESTAMP NOT NULL DEFAULT now(),
    expiration_time TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_user_sessions_user_id ON user_sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_user_sessions_expiration_time ON user_sessions(expiration_time);

-- Session cron jobs table
CREATE TABLE IF NOT EXISTS session_cron_jobs (
    cron_job_id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    last_checked     TIMESTAMP NOT NULL,
    sessions_deleted INTEGER   NOT NULL
);
