<template>
  <section class="hero ">
    <div class="hero-body">
      <div class="container">
        <div v-if="posts.length === 0" class="tile is-parent">
          <article class="tile is-child notification ">
            <p class="title">No post.</p>
          </article>
        </div>
        <div v-for="post in posts" :key="post.id">
          <section class="section">
            <div class="columns">
              <div class="column is-8 is-offset-2">
                <div class="content is-medium">
                  <h2 class="subtitle is-4">
                    {{ $moment(post.created).format('LLLL') }}
                  </h2>
                  <h1 class="title">{{ post.title }}</h1>
                  <p>
                    <img
                      :src="
                        'https://bucket-cloud-final.s3-ap-southeast-1.amazonaws.com/' +
                          post.photoId
                      "
                      :alt="post.photoId"
                    />
                  </p>
                  <p>
                    {{ post.content }}
                  </p>
                </div>
              </div>
            </div>
          </section>

          <div class="is-divider"></div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  async asyncData({ $axios }) {
    const { data } = await $axios.get(`/blog`)
    return { posts: data.results }
  }
}
</script>
