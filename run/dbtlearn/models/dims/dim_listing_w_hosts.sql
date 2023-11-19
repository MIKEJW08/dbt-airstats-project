
  
    

        create or replace transient table AIRBNB.DEV.dim_listing_w_hosts
         as
        (WITH listings AS (
    SELECT  
        *
    FROM AIRBNB.DEV.dim_listings_cleansed
), hosts AS (
    SELECT 
        *
    FROM AIRBNB.DEV.dim_hosts_cleansed
)
SELECT
    listings.listing_id, 
    listings.listing_name,
    listings.room_type,
    listings.minimum_nights,
    listings.price,
    listings.host_id,
    hosts.host_name,
    hosts.IS_SUPERHOST AS host_is_superhost,
    listings.created_at,
    GREATEST(listings.updated_at, hosts.updated_at) AS updated_at
FROM listings  
LEFT JOIN hosts ON listings.host_id = hosts.host_id
        );
      
  