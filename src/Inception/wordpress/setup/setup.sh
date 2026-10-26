#! /bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

POST_FILENAME="welcome-on-my-star-wars-blog"
POST_PAGE_NAME="Welcome on my Star Wars blog"
POST_IMAGE="darth-vader.jpg"

cd $SCRIPT_DIR

if [[ -z "$POST_FILENAME" || -z "$POST_PAGE_NAME" || ! -s "$POST_FILENAME" ]]; then
	echo "Invalid or missing files"
	exit 0
fi

# Create post from template

wp post create \
	"$POST_FILENAME" \
	"--post_title=$POST_PAGE_NAME" \
	--post_type=page \
	--post-author="1" \
	--post_status=publish \
	--allow-root 

wp media import \
	"$POST_IMAGE" \
	--post_id=5 \
	--featured_image \
	--allow-root

# Set post as new homepage

POST_ID=$(wp post list --post_type=page --name="welcome-on-my-star-wars-blog" --format=ids --allow-root)

wp option update \
	page_on_front \
	$POST_ID --allow-root

wp option update \
	show_on_front \
	"page" --allow-root

# Set image as Favicon

IMAGE_ID=$(wp post meta get --allow-root $POST_ID _thumbnail_id)

wp option update site_icon $IMAGE_ID --allow-root

# Remove default posts and pages

HELLO_WORLD_POST_ID=$(wp post --allow-root list --name="hello-world" --format=ids)
SAMPLE_PAGE_ID=$(wp post list --post_type=page --name="sample-page" --format=ids --allow-root)

wp post delete --allow-root $HELLO_WORLD_POST_ID $SAMPLE_PAGE_ID

POST_ID=$(wp post --allow-root --post_type=page list --name="$POST_FILENAME" --format=ids); \
echo $POST_ID; \
IMAGE_ID=$(wp post meta get --allow-root $POST_ID _thumbnail_id); \
echo $IMAGE_ID; \
wp option update site_icon $IMAGE_ID --allow-root
