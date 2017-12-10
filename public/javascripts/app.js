Vue.component('minefield-tile', {
  props: ['x', 'y'],

  template: `
    <td @click='clickedTile' class='minefield-tile' :class='{ dug : is_dug, mine : is_mine }'>
      {{ is_mine ? '' : nearby_mine_count }}
    </td>
  `,

  methods: {
    clickedTile() {
      axios.post('/api/games/dig_tile', {
        x: this.x,
        y: this.y
      }).then((response) => {
        this.is_dug = response.data.tile.is_dug;
        this.is_mine = response.data.tile.is_mine;
        this.nearby_mine_count = response.data.tile.nearby_mine_count;
      }).catch(error =>{
        console.error("Tile doesn't exist. This isn't good.")
        console.error(error)
      });
    },
  },

  data() {
    return {
      is_dug: false,
      is_mine: null,
      nearby_mine_count: null
    }
  }
});

new Vue({
  el: '.game-canvas',

  methods: {
    digTile(x, y) {
    }
  }
});