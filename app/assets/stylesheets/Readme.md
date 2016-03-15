---Overall Design Structure:


```
<html>
  <head>
  // SCSS -- Under Rails control
  </head>
  <body class="ember-application">
    <header>
      --- /application/shared/_header.scss
    </header>
    <main>
      --- /application/shared/_main.scss
    </main>
    <footer>
      --- /application/shared/_footer.scss
    </footer>
  </body>
</html>
```

--- /application/shared/_main.scss

```
<main>
  <left_sidebar>
    <genres_div>
      ---
    </genres_div>
    <categories_div>
      ---
    </categories_div>
  </left_sidebar>
  <central>
    <central_panel>
      <central_upper_panel>
        <genre_tagging>
          ---
        </genre_tagging>
        <fact_type_tagging>
          ---
        </fact_type_tagging>
        <category_tagging>
          ---
        </category_tagging>
        <post_date_tagging>
          ---
        </post_date_tagging>
      </central_upper_panel>
      <central_lower_panel>
        <topic_search>
          ---
        </topic_search>
        <topic_tagging>
          ---
        </topic_tagging>
      </central_lower_panel>
    </central_panel>
    <shared_panel>
      ---
    </shared_panel>
  </central>
  <right_sidebar>
    <genres_div>
      ---
    </genres_div>
    <categories_div>
      ---
    </categories_div>
  </right_sidebar>
</main>
```
