{**
 * Последняя активность
 * Топики отсортированные по времени последнего комментария
 *}

{component_define_params params=[ 'comments' ]}

<div class="ls-activity-block-recent-items">
    {foreach $comments as $comment}
        {$topic = $comment->getTarget()}

        {component 'activity' template='recent-item'
            user     = $comment->getUser()
            topic    = $topic
            date     = $comment->getDate()}
    {foreachelse}
        {component 'blankslate' text={lang 'common.empty'} mods='no-background'}
    {/foreach}
</div>