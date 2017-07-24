{component_define_params params=[ 'user', 'topic', 'date' ]}

<div class="ls-activity-block-recent-item">
    <div>
        <a href="{$topic->getUrl()}" class="ls-activity-block-recent-title" title="{$user->getDisplayName()} / {date_format date=$date hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y"}">{$topic->getTitle()|escape}</a>

        <a href="{$topic->getUrl()}#comments" class="ls-activity-block-recent-comments">
            <i class="ls-activity-block-recent-comments-icon"></i>
            {$topic->getCountComment()}
        </a>
    </div>
</div>