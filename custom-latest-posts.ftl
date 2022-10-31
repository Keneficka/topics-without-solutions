<#assign userId = webuisupport.path.rawParameters.name.get('user-id', '250') />
<#assign userName = liql("SELECT login FROM users WHERE id = '250'").data.items[0].login />
<#assign resp = liql("SELECT subject, view_href, board.title, board.view_href, replies.count(*), post_time_friendly FROM messages WHERE depth = 0 AND conversation.solved = false AND author.id = '${userId}' AND conversation.style='forum' AND board.id != 'abusereports' AND replies.count(*)>0 LIMIT 5").data.items />


<#--TABS-->
<button class="latest-posts-tab-ak">Latest Posts by ${userName}</button>
<button class="no-solution-tab-ak">Posts With No Marked Solution</button>

<#--BEGIN POSTS WITHOUT SOLUTIONS LIST-->
<div class="ak-no-solution-display" id="posts-hide-ak">
    <div class="lia-panel-content-wrapper">
        <div>
            <div class="SimpleMessageList">
                <div id="messageList" class="MessageList lia-component-forums-widget-message-list">
                    <span id="message-listmessageList"> </span>
                    <div class="t-data-grid single-message-list" id="grid">
                        <table role="presentation" class="lia-list-wide">
                            <thead class="lia-table-head" id="columns">
                                <tr>
                                    <th scope="col" class="messageSubjectColumn lia-data-cell-primary lia-data-cell-text t-first">
                                        Subject
                                    </th>
                                    <th scope="col" class="viewsCountColumn lia-data-cell-secondary lia-data-cell-integer">
                                        Replies
                                    </th>
                                    <th scope="col" class="messagePostDateColumn lia-data-cell-secondary lia-data-cell-date t-last">
                                        Posted
                                    </th>
                                </tr>
                            </thead>

                            <tbody>
                                <#list resp as post>
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
                                                <span class="local-date">&lrm;${post.post_time_friendly}</span>
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
</div>
<#--END POSTS WITHOUT SOLUTIONS LIST-->

<div class="ak-recent-posts-display" id="posts-show-ak">
    <@component id="forums.widget.recent-messages" />
</div>


<style>
    #posts-show-ak {
        display: block;
    }

    #posts-hide-ak {
        display: none;
    }

    .ak-recent-posts-display .lia-panel-heading-bar {
        display: none;
    }

    .ak-recent-posts-display .lia-view-all {
        display: none;
    }

    button.latest-posts-tab-ak:focus {
        outline: none !important;
    }

    button.no-solution-tab-ak:focus {
        outline: none !important;
    }
</style>

<@liaAddScript>
    ;(function($) {

        var recent = document.querySelector('.ak-recent-posts-display');
        var unsolved = document.querySelector('.ak-no-solution-display');

        var recentButton = document.querySelector('.latest-posts-tab-ak');
        var unsolvedButton = document.querySelector('.no-solution-tab-ak');

        recentButton.addEventListener("click", function(){
            recent.id = "posts-show-ak";
            unsolved.id = "posts-hide-ak"
        });

        unsolvedButton.addEventListener("click", function(){
            recent.id = "posts-hide-ak";
            unsolved.id = "posts-show-ak"
        });

    })(LITHIUM.jQuery);
</@liaAddScript>

<#--
TO DO:
Fix Tabs
Fix Height
Fix Display When No Results
Check on Time
Add View More
-->