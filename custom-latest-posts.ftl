<#assign userId = webuisupport.path.rawParameters.name.get('user-id', '250') />
<#assign userInfo = liql("SELECT login, messages.count(*) FROM users WHERE id = '${userId}'").data.items[0] />

<#if userInfo.messages.count gt 0 >

    <#assign userName = userInfo.login />
    <#assign resp = liql("SELECT subject, view_href, board.title, board.view_href, replies.count(*), post_time FROM messages WHERE depth = 0 AND conversation.solved = false AND author.id = '${userId}' AND conversation.style='forum' AND board.id != 'abusereports' AND replies.count(*)>0 LIMIT 5").data />


    <#--TABS AND VIEW MORE LINKS-->
    <div class="tab-container-ak" id="first-tab-ak">
        <a href="#" class="latest-posts-tab-ak tab-ak" id="active-tab-ak">Latest Posts by ${userName}</a>
        <a href="#" class="no-solution-tab-ak tab-ak" id="inactive-tab-ak">Unsolved Posts</a>
        <a href="/t5/forums/recentpostspage/post-type/message/user-id/${userId}" target="_blank" class="view-more-ak latest-view-more-ak" id="active-view-more-ak">View More</a>
        <a href="#" class="view-more-ak unsolved-view-more-ak" id="inactive-view-more-ak">View More</a>
    </div>

    <div class="tab-content-ak" id="no-adjustment-ak">

        <#--BEGIN POSTS WITHOUT SOLUTIONS LIST-->
        
        <div class="ak-no-solution-display tab-pane-ak" id="posts-hide-ak">
            <#if resp.size gt 0 >
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
                <style>
                    #second-tab-ak {
                            border-bottom: 1px solid #c4c4c4 !important;
                    }

                    #adjustment-ak {
                        margin-bottom: -1px !important;
                    }
                </style>
            </#if>
        </div>
        <#--END POSTS WITHOUT SOLUTIONS LIST-->

        <div class="ak-recent-posts-display tab-pane-ak" id="posts-show-ak">
            <@component id="forums.widget.recent-messages" />
        </div>

    </div>

    <style>
        #posts-show-ak {
            visibility: visible;
        }

        #posts-hide-ak {
            visibility: hidden;
        }

        .ak-recent-posts-display .lia-panel-heading-bar {
            display: none;
        }

        .ak-recent-posts-display .lia-view-all {
            display: none;
        }

        .latest-posts-tab-ak:focus {
            outline: none !important;
        }

        .no-solution-tab-ak:focus {
            outline: none !important;
        }

        #posts-show-ak table.lia-list-wide {
            border-top: none;
        }

        .tab-container-ak {
            margin-left: 0;
            border-bottom: 1px solid #c4c4c4;
        }

        .tab-container-ak .tab-ak {
            padding: 7px .6em 4px .6em;
            border-radius: 8px 8px 0 0;
            margin-left: 3px;
            border: 1px solid #c4c4c4;
            border-bottom: none;
            background: #DDE;
            text-decoration: none;
        }

        .tab-container-ak #active-tab-ak {
            background: white;
            border-bottom: 1px solid transparent;
        }

        .tab-ak.latest-posts-tab-ak {
            margin-left: 8px;
        }

        #second-tab-ak {
            border-bottom: 2px solid #c4c4c4;
        }

        div.tab-container-ak {
            margin-top: 20px;
        }

        #reduced-padding-ak {
            padding-top: 4px;
        }

        .tab-pane-ak {
            margin-right: -100%;
            width: 100%;
        }

        .tab-content-ak {
            display: flex;
        }

        #adjustment-ak {
            margin-bottom: -2px 
        }

        #active-view-more-ak {
            display: inline;
        }

        #inactive-view-more-ak {
            display: none;
        }

        .view-more-ak {
            float: right;
            margin-right: 8px;
        }

        .no-unsolved-message-ak {
            padding: 2px 15px;
        }
    </style>

    <@liaAddScript>
        ;(function($) {

            var recent = document.querySelector('.ak-recent-posts-display');
            var unsolved = document.querySelector('.ak-no-solution-display');

            var recentButton = document.querySelector('.latest-posts-tab-ak');
            var unsolvedButton = document.querySelector('.no-solution-tab-ak');

            var tabContainer = document.querySelector('.tab-container-ak')
            var tabContent = document.querySelector('.tab-content-ak')

            var latestMore = document.querySelector('.latest-view-more-ak')
            var unsolvedMore = document.querySelector('.unsolved-view-more-ak')

            recentButton.addEventListener("click", function(event){
                event.preventDefault();
                recent.id = "posts-show-ak";
                unsolved.id = "posts-hide-ak"
                unsolvedButton.id = "inactive-tab-ak";
                recentButton.id = "active-tab-ak";
                tabContainer.id = "first-tab-ak";
                tabContent.id = "no-adjustment-ak";
                latestMore.id = "active-view-more-ak";
                unsolvedMore.id = "inactive-view-more-ak";
            });

            unsolvedButton.addEventListener("click", function(event){
                event.preventDefault();
                recent.id = "posts-hide-ak";
                unsolved.id = "posts-show-ak"
                unsolvedButton.id = "active-tab-ak";
                recentButton.id = "inactive-tab-ak";
                tabContainer.id = "second-tab-ak";
                tabContent.id = "adjustment-ak";
                latestMore.id = "inactive-view-more-ak";
                unsolvedMore.id = "active-view-more-ak";
            });

        })(LITHIUM.jQuery);
    </@liaAddScript>

</#if>
