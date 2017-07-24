{**
 * Блог в списке блогов
 *
 * @param object $blog
 *}

{$component = 'blog-list-item'}
{component_define_params params=[ 'blog' ]}

{* Заголовок *}
{capture 'title'}
    {if $blog->getType() == 'close'}
        {component 'syn-icon' icon='lock' attributes=[ title => {lang 'blog.private'} ]}
    {/if}

    <a href="{$blog->getUrlFull()}">{$blog->getTitle()|escape}</a>
{/capture}

{* Описание *}
{capture 'content'}
    {* Рейтинг *}
    <div class="{$component}-users" title="{lang 'blog.users.readers_total'}">
        <i class="fa fa-user-o" aria-hidden="true"></i> {$blog->getCountUser()}
    </div>

    <div class="ls-item-description">
        {$blog->getDescription()|strip_tags|truncate:170}
    </div>
	
	{$category = $blog->category->getCategory()}

    {if $category}
        <div class="{$component}-category">
            {component 'icon' icon='folder'}
            {$category->getTitle()}
        </div>
    {/if}

{/capture}

{component 'item'
    classes='blog-list-item'
    title=$smarty.capture.title
    content=$smarty.capture.content
    image=[
        'url' => $blog->getUrlFull(),
        'path' => $blog->getAvatarPath(48),
        'alt' => $blog->getTitle()|escape
    ]}