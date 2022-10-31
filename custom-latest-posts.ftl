<#assign userId = webuisupport.path.rawParameters.name.get('user-id', '250') />

<#assign resp = liql("SELECT subject, view_href, board.title, board.view_href, replies.count(*), post_time_friendly FROM messages WHERE depth = 0 AND conversation.solved = false AND author.id = '${userId}' AND conversation.style='forum' AND board.id != 'abusereports' AND replies.count(*)>0 LIMIT 5").data.items />

<table>
    <tr>
        <th>Subject</th>
        <th>Replies</th>
        <th>Posted</th>
    </tr>

    <#list resp as post>
        <tr>
            <td><a href="${post.view_href}" target="_blank">${post.subject}</a><br><a href="${post.board.view_href}" target="_blank">${post.board.title}</a></td>
            <td>${post.replies.count}</td>
            <td>${post.post_time_friendly}</td>
        </tr>
    </#list>
</table>