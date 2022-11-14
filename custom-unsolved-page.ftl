<#assign userId = webuisupport.path.rawParameters.name.get('user-id', '250') />
<#assign userName = liql("SELECT login FROM users WHERE id = '${userId}'").data.items[0].login />

<#--GET LIST OF BOARDS-->
    <#assign boardListSetting = settings.name.get("custom.unsolved_board_list", "")?trim />
    <#assign boardListSplit = boardListSetting?split(",") />
    <#assign boardListIds = "'" + boardListSplit?join("','") + "'" />


<#assign count = liql("SELECT count(*) FROM messages WHERE depth = 0 AND conversation.solved = false AND author.id = '${userId}' AND conversation.style='forum' AND board.id IN (${boardListIds}) AND replies.count(*)>0").data.count />
<#assign results_list_size = 10 />
<#assign page_number = webuisupport.path.rawParameters.name.get('page', '1')?number />
<#assign offSet = results_list_size * (page_number - 1) />



<#assign resp = liql("SELECT subject, view_href, board.title, board.view_href, replies.count(*), post_time FROM messages WHERE depth = 0 AND conversation.solved = false AND author.id = '${userId}' AND conversation.style='forum' AND board.id IN (${boardListIds}) AND replies.count(*)>0 LIMIT ${results_list_size} OFFSET ${offSet}").data />

<#--PAGE TITLE-->
    <div class="lia-page-header">
		<h1 class="PageTitle lia-component-common-widget-page-title"><span class="lia-link-navigation lia-link-disabled" id="link_1">${userName}'s Unsolved Posts</span></h1>
	</div>
<#--PAGE TITLE-->

<#--BEGIN POSTS WITHOUT SOLUTIONS LIST-->        
    <div class="ak-no-solution-display tab-pane-ak">
        <#if count gt 0 >
            <div class="lia-panel-content-wrapper">
                <div>
                    <div class="SimpleMessageList">
                        <div id="messageList" class="MessageList lia-component-forums-widget-message-list">
                            <span id="message-listmessageList"> </span>
                            <div class="t-data-grid single-message-list" id="grid">
                                <table role="presentation" class="lia-list-wide">
                                    <thead class="lia-table-head" id="columns">
                                        <tr>
                                            <th scope="col" class="messageSubjectColumn lia-data-cell-primary lia-data-cell-text t-first" id="reduced-padding-ak">
                                                Subject
                                            </th>
                                            <th scope="col" class="viewsCountColumn lia-data-cell-secondary lia-data-cell-integer" id="reduced-padding-ak">
                                                Replies
                                            </th>
                                            <th scope="col" class="messagePostDateColumn lia-data-cell-secondary lia-data-cell-date t-last" id="reduced-padding-ak">
                                                Posted
                                            </th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <#list resp.items as post>
                                            <#if post?counter == 1>
                                            <tr class="lia-list-row lia-row-odd lia-js-data-messageRevision-1 t-first">
                                            <#else>
                                            <tr class="lia-list-row lia-row-odd lia-js-data-messageRevision-1">
                                            </#if>
                                                <td class="messageSubjectColumn lia-data-cell-primary lia-data-cell-text">
                                                    <div class="MessageSubjectCell">
                                                        <div class="MessageSubject">
                                                            <div class="MessageSubjectIcons ">
                                                                <h2 itemprop="name" class="message-subject">
                                                                    <span class="lia-message-read">
                                                                        <a class="page-link lia-link-navigation lia-custom-event" id="link_20" href="${post.view_href}">
                                                                            ${post.subject}                      
                                                                        </a>               
                                                                    </span>
                                                                </h2>
                                                            </div>
                                                            <div class="message-subject-board">
                                                                <a class="local-time xsmall-text lia-link-navigation" id="link_21" href="${post.board.view_href}">
                                                                    ${post.board.title}
                                                                </a>
                                                            </div>
                                                        </div>    
                                                    </div>
                                                </td>
                                                <td class="viewsCountColumn lia-data-cell-secondary lia-data-cell-integer">
                                                    ${post.replies.count}
                                                </td>
                                                <td class="messagePostDateColumn lia-data-cell-secondary lia-data-cell-date">
                                                    <span class="DateTime">
                                                        <span class="local-date">&lrm;${post.post_time?date?string}</span>
                                                        <span class="local-time">${post.post_time?time?string.short}</span>
                                                    </span>
                                                </td>
                                            </tr>
                                        </#list>                                
                                    </tbody>
                                </table>
                            </div>
                        </div>                               
                    </div>
                </div>
            </div>         
        <#else>
            <div class="no-unsolved-message-ak">
                ${userName} has no unsolved posts!
            </div>
        </#if>
    </div>
<#--END POSTS WITHOUT SOLUTIONS LIST-->
    
<#--PAGINATION-->
    <#assign pageable_item = webuisupport.paging.pageableItem.setCurrentPageNumber(page_number)
    .setItemsPerPage(results_list_size).setTotalItems(count)
    .setPagingMode("enumerated").build />
    <@component id="common.widget.pager" pageableItem=pageable_item />
<#--PAGINATION-->

<style>
    #lia-body .lia-quilt-column-alley.lia-quilt-column-alley-single {
        padding-top: 0;
    }
</style>