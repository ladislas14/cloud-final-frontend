<template>
  <section class="hero ">
    <div class="hero-body">
      <div class="container">
        <h1 class="title">
          Posts management
        </h1>
        <h3 class="subtitle">
          <nuxt-link to="/admin/add">New Post</nuxt-link>
        </h3>
        <div v-if="posts && posts.length === 0" class="tile is-parent">
          <article class="tile is-child notification ">
            <p class="title">No post.</p>
          </article>
        </div>
        <table class="table is-fullwidth">
          <thead>
            <tr>
              <th>ID</th>
              <th>Title</th>
              <th>Slug</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="post in posts" :key="post.id">
              <td>{{ post.id }}</td>
              <td>{{ post.title }}</td>
              <td>{{ post.slug }}</td>
              <td>
                <nuxt-link :to="'admin/' + post.slug" class="button"
                  >Edit</nuxt-link
                >
                <button
                  class="button is-danger"
                  @click.prevent="removePost({ id: post.id })"
                >
                  Remove
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  middleware: 'authenticated',
  async asyncData({ $axios }) {
    const { data } = await $axios.get(`/blog`)
    return { posts: data.results }
  },
  methods: {
    async removePost({ id }) {
      this.$axios.setToken(this.$store.state.auth.accessToken, 'Bearer')
      const response = await this.$axios.delete(`/blog/${id}`)
      if (response.status === 200) {
        this.posts = this.posts.filter((post) => post.id !== id)
      }
    }
  }
}
</script>
