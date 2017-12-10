Vue.component('minefield-tile', {
  props: ['x', 'y'],

  template: `
    <td @click='clickedTile' class='minefield-tile' :class='{ dug : is_dug, mine : is_mine }'>
      {{ is_mine ? '' : nearby_mine_count }}
    </td>
  `,

  methods: {
    clickedTile() {
      this.$emit('clicked-tile', this);
    },

    tile_state() {
      if(this.$store.state.tiles[this.x] == undefined)
        return undefined;

      return this.$store.state.tiles[this.x][this.y];
    }
  },

  computed: {
    is_dug () {
      let tile_state = this.tile_state();
      return tile_state ? tile_state.is_dug : undefined;
    },
    is_mine () {
      let tile_state = this.tile_state();
      return tile_state ? tile_state.is_mine : undefined;
    },
    nearby_mine_count () {
      let tile_state = this.tile_state();
      return tile_state ? tile_state.nearby_mine_count : undefined;
    }
  }

});

const store = new Vuex.Store({
  state: {
    tiles: {}
  },

  mutations: {
    setTiles(state, tiles) {
      state.tiles = tiles;
    },

    updateTiles(state, tiles) {
      tiles.forEach((t) => {
        state.tiles[t.x][t.y] = t;
      });
    }
  },

  actions: {
    initialize (context) {
      axios.get('/api/games/1/tiles').then(response => {
        var tiles = response.data.tiles;
        var tiles_hash = {}
        tiles.forEach((t) => {
          tiles_hash[t.x] = tiles_hash[t.x] ? tiles_hash[t.x] : {};
          tiles_hash[t.x][t.y] = t;
        });

        context.commit('setTiles', tiles_hash);
      });
    }
  }
});

new Vue({
  el: '.game-canvas',
  store,

  mounted() {
    this.initializeDataStore();
  },

  methods: {
    initializeDataStore() {
      store.dispatch('initialize');
    },

    digTile(tile) {
      axios.post('/api/games/dig_tile', {
        x: tile.x,
        y: tile.y
      }).then((response) => {
        store.commit('updateTiles', response.data.tiles);
      }).catch(error =>{
        console.error("Tile doesn't exist. This isn't good.")
        console.error(error)
      });
    }
  }
});
