# topics-without-solutions
This is for the Khoros community platform. It includes a tabbed component for the view profile page that includes the existing Latest Posts component and a user's unsolved posts on the second tab. View more links to a paginated custom page with the full list of unsolved posts.

## Component
**custom-latest-posts.ftl** is a custom component that can be added to the profile page in place of the OOB "Latest Posts" component.

## Custom Page
**custom-unsolved-page.ftl** is a custom component that should be added to a one column custom page named **unsolvedpostpage**

## Admin Setting
Both the profile page component and the custom page use a custom setting added by Khoros support named **custom.unsolved_board_list** which holds a comma seperated list of board IDs to include.